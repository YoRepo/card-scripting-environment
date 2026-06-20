--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 超量叠光延迟  (ID: 78610936)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 115
--
-- Effect Text:
-- 不能对应这张卡的发动让魔法·陷阱·怪兽的效果发动。
-- ①：以持有超量素材的对方场上1只超量怪兽为对象才能发动。那只怪兽的超量素材全部取除，作为对象的怪兽回到额外卡组。取除的超量素材之中有怪兽卡的场合，再把那些怪兽从墓地尽可能往对方场上守备表示特殊召唤。这
-- 个效果特殊召唤的怪兽的等级下降1星。
--[[ __CARD_HEADER_END__ ]]

--エクシーズ・オーバーディレイ
function c78610936.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOEXTRA+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c78610936.target)
	e1:SetOperation(c78610936.activate)
	c:RegisterEffect(e1)
end
function c78610936.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAbleToExtra() and c:GetOverlayCount()>0
end
function c78610936.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c78610936.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c78610936.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c78610936.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.SetChainLimit(aux.FALSE)
	end
end
function c78610936.spfilter(c,e,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
end
function c78610936.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local mg=tc:GetOverlayGroup()
	Duel.SendtoGrave(mg,REASON_EFFECT)
	if Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)>0 then
		local g=mg:Filter(aux.NecroValleyFilter(c78610936.spfilter),nil,e,tp)
		local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
		if ft>0 and g:GetCount()>0 then
			if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
			if g:GetCount()>ft then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				g=g:Select(tp,ft,ft,nil)
			end
			local tc=g:GetFirst()
			while tc do
				Duel.SpecialSummonStep(tc,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
				if tc:GetLevel()>0 then
					local e1=Effect.CreateEffect(e:GetHandler())
					e1:SetType(EFFECT_TYPE_SINGLE)
					e1:SetCode(EFFECT_UPDATE_LEVEL)
					e1:SetValue(-1)
					e1:SetReset(RESET_EVENT+RESETS_STANDARD)
					tc:RegisterEffect(e1)
				end
				tc=g:GetNext()
			end
			Duel.SpecialSummonComplete()
		end
	end
end
