--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 碳素龙  (ID: 15981690)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 3
-- ATK 800 | DEF 600
--
-- Effect Text:
-- 「碳素龙」的②的效果1回合只能使用1次。
-- ①：这张卡和炎属性怪兽进行战斗的伤害计算时发动。这张卡的攻击力只在那次伤害计算时上升1000。
-- ②：自己主要阶段把墓地的这张卡除外才能发动。从手卡·卡组把1只7星以下的龙族通常怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--カーボネドン
function c15981690.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15981690,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c15981690.upcon)
	e1:SetOperation(c15981690.upop)
	c:RegisterEffect(e1)
	--special
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(15981690,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,15981690)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c15981690.sptg)
	e2:SetOperation(c15981690.spop)
	c:RegisterEffect(e2)
end
function c15981690.upcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsAttribute(ATTRIBUTE_FIRE)
end
function c15981690.upop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(1000)
		c:RegisterEffect(e1)
	end
end
function c15981690.spfilter(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsLevelBelow(7) and c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c15981690.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c15981690.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c15981690.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c15981690.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
