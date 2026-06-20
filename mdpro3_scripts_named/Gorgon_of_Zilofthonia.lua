--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 美丽的磁律机坏  (ID: 12067160)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Reptile
-- ATK 100 | LINK
--
-- Effect Text:
-- 效果怪兽2只以上
-- 自己不能在这张卡所连接区让怪兽出现。
-- ①：这张卡所连接区的怪兽不能攻击，那些怪兽的所发动的效果无效化。
-- ②：这张卡的攻击力上升这张卡所连接区的怪兽的原本攻击力数值。
-- ③：这张卡所连接区没有怪兽存在的场合，这张卡不会被战斗以及怪兽的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--麗しき磁律機壊
local s,id,o=GetID()
function s.initial_effect(c)
	--material
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_EFFECT),2)
	c:EnableReviveLimit()
	--zone limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_MUST_USE_MZONE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTargetRange(1,0)
	e1:SetValue(s.zonelimit)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(s.antg)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(s.discon)
	e3:SetOperation(s.disop)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(s.atkval)
	c:RegisterEffect(e4)
	--indes
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetValue(1)
	e5:SetCondition(s.incon)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e6:SetValue(s.efilter)
	c:RegisterEffect(e6)
end
function s.zonelimit(e)
	return 0x7f007f & ~e:GetHandler():GetLinkedZone()
end
function s.antg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return rc and re:IsActiveType(TYPE_MONSTER) and rc:IsRelateToChain() and e:GetHandler():GetLinkedGroup():IsContains(rc)
		and rc:IsCanBeDisabledByEffect(e) and Duel.IsChainDisablable(ev)
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,id)
	Duel.NegateEffect(ev)
end
function s.atkval(e,c)
	local g=e:GetHandler():GetLinkedGroup():Filter(Card.IsFaceup,nil)
	return g:GetSum(Card.GetBaseAttack)
end
function s.incon(e)
	local c=e:GetHandler()
	return c:IsType(TYPE_LINK) and c:GetLinkedGroupCount()==0
end
function s.efilter(e,re)
	return re:IsActiveType(TYPE_EFFECT)
end
