--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 变形斗士·紧急迎击  (ID: 49833312)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 38
--
-- Effect Text:
-- 对方宣言直接攻击时，自己场上没有怪兽存在的场合才能发动。那次攻击无效，从手卡把1只名字带有「变形斗士」的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--D・スクランブル
function c49833312.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c49833312.condition)
	e1:SetTarget(c49833312.target)
	e1:SetOperation(c49833312.activate)
	c:RegisterEffect(e1)
end
function c49833312.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c49833312.filter(c,e,tp)
	return c:IsSetCard(0x26) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c49833312.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c49833312.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c49833312.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c49833312.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
