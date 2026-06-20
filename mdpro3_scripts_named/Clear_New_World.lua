--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 新世坏  (ID: 21570001)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己场上1只表侧表示怪兽为对象才能发动。那只怪兽破坏，和那只怪兽是原本的种族·属性不同并持有比那只怪兽的原本等级低的等级的1只怪兽从卡组守备表示特殊召唤。这个效果特殊召唤的怪兽的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--新世壊
function c21570001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,21570001+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c21570001.target)
	e1:SetOperation(c21570001.activate)
	c:RegisterEffect(e1)
end
function c21570001.filter(c,e,tp)
	return c:IsFaceup() and c:GetOriginalLevel()>1 and Duel.GetMZoneCount(tp,c)>0
		and Duel.IsExistingMatchingCard(c21570001.filter2,tp,LOCATION_DECK,0,1,nil,e,tp,c)
end
function c21570001.filter2(c,e,tp,tc)
	return c:IsLevelBelow(tc:GetOriginalLevel()-1)
		and not c:IsRace(tc:GetOriginalRace())
		and not c:IsAttribute(tc:GetOriginalAttribute())
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c21570001.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c21570001.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c21570001.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c21570001.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c21570001.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c21570001.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp,tc)
		if #g>0 then
			local sc=g:GetFirst()
			if Duel.SpecialSummonStep(sc,0,tp,tp,false,false,POS_FACEUP_DEFENSE) then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_DISABLE)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD)
				sc:RegisterEffect(e1)
				local e2=Effect.CreateEffect(c)
				e2:SetType(EFFECT_TYPE_SINGLE)
				e2:SetCode(EFFECT_DISABLE_EFFECT)
				e2:SetValue(RESET_TURN_SET)
				e2:SetReset(RESET_EVENT+RESETS_STANDARD)
				sc:RegisterEffect(e2)
			end
			Duel.SpecialSummonComplete()
		end
	end
end
