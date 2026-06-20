--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 调整抓取  (ID: 50951359)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方对同调怪兽的同调召唤成功时才能发动。那1只作为同调素材的调整从对方墓地在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--チューナー・キャプチャー
function c50951359.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c50951359.condition)
	e1:SetTarget(c50951359.target)
	e1:SetOperation(c50951359.activate)
	c:RegisterEffect(e1)
end
function c50951359.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsSummonType(SUMMON_TYPE_SYNCHRO) and ep~=tp
end
function c50951359.filter(c,e,tp,mg)
	return mg:IsContains(c) and c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c50951359.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c50951359.filter(chkc,e,tp,eg:GetFirst():GetMaterial()) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c50951359.filter,tp,0,LOCATION_GRAVE,1,nil,e,tp,eg:GetFirst():GetMaterial()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c50951359.filter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp,eg:GetFirst():GetMaterial())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c50951359.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
