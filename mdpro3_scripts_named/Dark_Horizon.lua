--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 暗黑边界  (ID: 16964437)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己因战斗·效果受到伤害时才能发动。把持有受到的伤害数值以下的攻击力的1只魔法师族·暗属性怪兽从卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ダーク・ホライズン
function c16964437.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetCondition(c16964437.condition)
	e1:SetTarget(c16964437.target)
	e1:SetOperation(c16964437.activate)
	c:RegisterEffect(e1)
end
function c16964437.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c16964437.filter(c,e,tp,dam)
	return c:IsRace(RACE_SPELLCASTER) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsAttackBelow(dam) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c16964437.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c16964437.filter,tp,LOCATION_DECK,0,1,nil,e,tp,ev) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c16964437.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c16964437.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp,ev)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
