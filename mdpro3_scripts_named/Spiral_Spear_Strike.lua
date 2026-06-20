--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 螺旋枪杀  (ID: 49328340)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己的「暗黑骑士 盖亚」「疾风之暗黑骑士 盖亚」「龙骑士 盖亚」向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
-- ②：这张卡的①的效果适用让「龙骑士 盖亚」给与对方战斗伤害的场合发动。自己从卡组抽2张，那之后选1张手卡丢弃。
--[[ __CARD_HEADER_END__ ]]

--螺旋槍殺
function c49328340.initial_effect(c)
	aux.AddCodeList(c,6368038,16589042,66889139)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c49328340.pietg)
	c:RegisterEffect(e2)
	--shuffle
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(49328340,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c49328340.condition)
	e3:SetTarget(c49328340.target)
	e3:SetOperation(c49328340.operation)
	c:RegisterEffect(e3)
end
function c49328340.pietg(e,c)
	return c:IsCode(6368038,16589042,66889139)
end
function c49328340.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return tc:IsControler(tp) and bc and bc:IsDefensePos() and tc:IsCode(66889139)
end
function c49328340.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c49328340.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	if Duel.Draw(tp,2,REASON_EFFECT)==2 then
		Duel.ShuffleHand(tp)
		Duel.BreakEffect()
		Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
	end
end
