--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 恐龙摔跤手·嵌合摔跤暴龙  (ID: 22900219)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 8
-- ATK 3500 | DEF 0
-- Setcode: 282
--
-- Effect Text:
-- 「恐龙摔跤手」连接怪兽＋「恐龙摔跤手」怪兽
-- ①：这张卡进行战斗的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
-- ②：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
-- ③：对方不能选择其他怪兽作为攻击对象。
-- ④：这张卡战斗破坏怪兽的场合发动。这张卡的攻击力上升500。
-- ⑤：这张卡被效果破坏的场合发动。对方的攻击表示怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--ダイナレスラー・キメラ・Tレッスル
function c22900219.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c22900219.matfilter1,aux.FilterBoolFunction(Card.IsFusionSetCard,0x11a),true)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c22900219.actlimit)
	e1:SetCondition(c22900219.actcon)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--atk limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(c22900219.atklimit)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetCondition(c22900219.atkcon)
	e4:SetOperation(c22900219.atkop)
	c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetCondition(c22900219.descon)
	e5:SetTarget(c22900219.destg)
	e5:SetOperation(c22900219.desop)
	c:RegisterEffect(e5)
end
function c22900219.matfilter1(c)
	return c:IsFusionType(TYPE_LINK) and c:IsFusionSetCard(0x11a)
end
function c22900219.actlimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c22900219.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end
function c22900219.atklimit(e,c)
	return c~=e:GetHandler()
end
function c22900219.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsRelateToBattle()
end
function c22900219.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
end
function c22900219.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT)
end
function c22900219.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAttackPos,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c22900219.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAttackPos,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
