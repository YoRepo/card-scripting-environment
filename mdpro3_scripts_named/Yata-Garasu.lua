--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 八汰乌  (ID: 3078576)
-- Type: Monster / Effect / Spirit
-- Attribute: WIND
-- Race: Fiend
-- Level 2
-- ATK 200 | DEF 100
--
-- Effect Text:
-- 这张卡不能特殊召唤。
-- ①：这张卡给与对方战斗伤害的场合发动。下次的对方抽卡阶段跳过。
-- ②：这张卡召唤·反转的回合的结束阶段发动。这张卡回到手卡。
--[[ __CARD_HEADER_END__ ]]

--八汰烏
function c3078576.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--skip draw
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(3078576,1))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_DAMAGE)
	e4:SetCondition(c3078576.skipcon)
	e4:SetOperation(c3078576.skipop)
	c:RegisterEffect(e4)
end
function c3078576.skipcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c3078576.skipop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetCode(EFFECT_SKIP_DP)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
end
