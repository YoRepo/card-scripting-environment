--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 骨猪一掷  (ID: 82593786)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 2
-- ATK 700 | DEF 600
--
-- Effect Text:
-- 怪兽进行战斗的战斗步骤时，把墓地的这张卡从游戏中除外才能发动。那只怪兽的攻击无效。这个效果在对方回合也能发动。「骨猪一掷」的效果在决斗中只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--タスケルトン
function c82593786.initial_effect(c)
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82593786,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,82593786+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c82593786.condition)
	e1:SetCost(aux.bfgcost)
	e1:SetOperation(c82593786.operation)
	c:RegisterEffect(e1)
end
function c82593786.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()~=nil
end
function c82593786.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
