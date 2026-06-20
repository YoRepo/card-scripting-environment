--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 时间机械  (ID: 80987696)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己或者对方的怪兽1只被战斗破坏送去墓地时才能发动。在那只怪兽被破坏时的控制者场上以相同表示形式把那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--時の機械－タイム・マシーン
function c80987696.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetTarget(c80987696.target)
	e1:SetOperation(c80987696.activate)
	c:RegisterEffect(e1)
end
function c80987696.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tc:GetPreviousControler(),LOCATION_MZONE)>0 and eg:GetCount()==1
		and tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_BATTLE)
		and tc:IsCanBeSpecialSummoned(e,0,tp,false,false,tc:GetPreviousPosition(),tc:GetPreviousControler()) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,eg,1,0,0)
end
function c80987696.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tc:GetPreviousControler(),false,false,tc:GetPreviousPosition())
	end
end
