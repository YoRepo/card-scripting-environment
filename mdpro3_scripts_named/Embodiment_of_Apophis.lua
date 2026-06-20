--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 阿匹卜之化神  (ID: 28649820)
-- Type: Trap / Equip
-- Attribute: EARTH
-- Race: Reptile
-- Level 4
-- ATK 1600 | DEF 1800
-- Setcode: 456
--
-- Effect Text:
-- ①：自己·对方的主要阶段才能把这张卡发动。这张卡变成通常怪兽（爬虫类族·地·4星·攻1600/守1800）在怪兽区域特殊召唤（也当作陷阱卡使用）。
--[[ __CARD_HEADER_END__ ]]

--アポピスの化神
function c28649820.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c28649820.condition)
	e1:SetTarget(c28649820.target)
	e1:SetOperation(c28649820.activate)
	c:RegisterEffect(e1)
end
function c28649820.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c28649820.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,28649820,0,TYPES_NORMAL_TRAP_MONSTER,1600,1800,4,RACE_REPTILE,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c28649820.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,28649820,0,TYPES_NORMAL_TRAP_MONSTER,1600,1800,4,RACE_REPTILE,ATTRIBUTE_EARTH) then return end
	c:AddMonsterAttribute(TYPE_NORMAL+TYPE_TRAP)
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
end
