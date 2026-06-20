--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 八俣大蛇  (ID: 76862289)
-- Type: Monster / Effect / Spirit
-- Attribute: FIRE
-- Race: Dragon
-- Level 7
-- ATK 2600 | DEF 3100
--
-- Effect Text:
-- 这张卡不能特殊召唤。
-- ①：这张卡给与对方战斗伤害的场合发动。自己直到手卡变成5张为止从卡组抽卡。
-- ②：这张卡召唤·反转的回合的结束阶段发动。这张卡回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--八俣大蛇
function c76862289.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--draw
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(76862289,1))
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_DAMAGE)
	e4:SetCondition(c76862289.drcon)
	e4:SetTarget(c76862289.drtg)
	e4:SetOperation(c76862289.drop)
	c:RegisterEffect(e4)
end
function c76862289.drcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c76862289.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	local ht=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ht<5 then
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,5-ht)
	end
end
function c76862289.drop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ht=Duel.GetFieldGroupCount(p,LOCATION_HAND,0)
	if ht<5 then
		Duel.Draw(p,5-ht,REASON_EFFECT)
	end
end
