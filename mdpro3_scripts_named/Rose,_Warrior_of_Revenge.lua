--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 复仇的女战士 罗丝  (ID: 1557341)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Warrior
-- Level 4
-- ATK 1600 | DEF 600
--
-- Effect Text:
-- ①：这张卡给与对方战斗伤害的场合发动。给与对方300伤害。
--[[ __CARD_HEADER_END__ ]]

--復讐の女戦士ローズ
function c1557341.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1557341,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c1557341.condition)
	e1:SetTarget(c1557341.target)
	e1:SetOperation(c1557341.operation)
	c:RegisterEffect(e1)
end
function c1557341.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c1557341.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(300)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end
function c1557341.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
