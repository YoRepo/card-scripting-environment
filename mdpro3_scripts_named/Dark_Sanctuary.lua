--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 暗黑圣域  (ID: 16625614)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己的「通灵盘」的效果要让「死之信息」卡出现的场合，可以让那卡作为通常怪兽（恶魔族·暗·1星·攻/守0）特殊召唤。这个效果特殊召唤的卡不受「通灵盘」以外的卡的效果影响，不会被作为攻击对象（自己场上
-- 只有被这个效果适用的怪兽存在的状态中对方的攻击变成对自己的直接攻击）。
-- ②：对方怪兽的攻击宣言时发动。进行1次投掷硬币。表的场合，那次攻击无效，给与对方那只对方怪兽的攻击力一半数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--ダーク・サンクチュアリ
function c16625614.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--update effect check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(16625614)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	c:RegisterEffect(e2)
	--negate attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCategory(CATEGORY_COIN)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCondition(c16625614.condition)
	e4:SetTarget(c16625614.target)
	e4:SetOperation(c16625614.operation)
	c:RegisterEffect(e4)
end
function c16625614.efilter(e,te)
	local tc=te:GetHandler()
	return not tc:IsCode(94212438)
end
function c16625614.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c16625614.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c16625614.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local coin=Duel.TossCoin(tp,1)
	if coin==1 then
		if Duel.NegateAttack() then
			Duel.Damage(1-tp,math.floor(tc:GetAttack()/2),REASON_EFFECT)
		end
	end
end
