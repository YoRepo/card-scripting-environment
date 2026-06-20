--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 黑魔导师 库兰  (ID: 46128076)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 2
-- ATK 1200 | DEF 0
-- Setcode: 110
--
-- Effect Text:
-- 自己的准备阶段时，给与对方基本分对方场上存在的怪兽数×300分数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--黒魔導師クラン
function c46128076.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46128076,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c46128076.condition)
	e1:SetTarget(c46128076.target)
	e1:SetOperation(c46128076.operation)
	c:RegisterEffect(e1)
end
function c46128076.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c46128076.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*300)
end
function c46128076.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	Duel.Damage(p,ct*300,REASON_EFFECT)
end
