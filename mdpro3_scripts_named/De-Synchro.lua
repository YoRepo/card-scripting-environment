--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 同调解除  (ID: 32441317)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 23
--
-- Effect Text:
-- ①：以场上1只同调怪兽为对象才能发动。那只同调怪兽回到额外卡组。那之后，若作为回到额外卡组的那只怪兽的同调召唤的素材用过的一组怪兽在自己墓地齐集，可以把那一组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--シンクロキャンセル
function c32441317.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOEXTRA+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c32441317.target)
	e1:SetOperation(c32441317.activate)
	c:RegisterEffect(e1)
end
function c32441317.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsAbleToExtra()
end
function c32441317.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c32441317.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32441317.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c32441317.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
end
function c32441317.mgfilter(c,e,tp,sync)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE)
		and bit.band(c:GetReason(),0x80008)==0x80008 and c:GetReasonCard()==sync
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c32441317.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	local mg=tc:GetMaterial()
	local ct=mg:GetCount()
	if Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_EXTRA)
		and tc:IsSummonType(SUMMON_TYPE_SYNCHRO)
		and ct>0 and ct<=Duel.GetLocationCount(tp,LOCATION_MZONE)
		and (not Duel.IsPlayerAffectedByEffect(tp,59822133) or ct==1)
		and mg:FilterCount(aux.NecroValleyFilter(c32441317.mgfilter),nil,e,tp,tc)==ct
		and Duel.SelectYesNo(tp,aux.Stringid(32441317,0)) then
		Duel.BreakEffect()
		Duel.SpecialSummon(mg,0,tp,tp,false,false,POS_FACEUP)
	end
end
