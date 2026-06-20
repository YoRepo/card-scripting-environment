--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 不死之炎鸟  (ID: 38538445)
-- Type: Monster / Effect / Spirit
-- Attribute: FIRE
-- Race: Winged Beast
-- Level 4
-- ATK 1200 | DEF 0
--
-- Effect Text:
-- 这张卡不能特殊召唤。召唤·反转回合的结束阶段时回到主人的手卡。这张卡给与对方玩家战斗伤害的场合，自己的基本分回复那个战斗伤害的数值。
--[[ __CARD_HEADER_END__ ]]

--不死之炎鳥
function c38538445.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--recover
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(38538445,1))
	e4:SetCategory(CATEGORY_RECOVER)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_DAMAGE)
	e4:SetCondition(c38538445.condition)
	e4:SetTarget(c38538445.target)
	e4:SetOperation(c38538445.operation)
	c:RegisterEffect(e4)
end
function c38538445.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c38538445.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ev)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ev)
end
function c38538445.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
