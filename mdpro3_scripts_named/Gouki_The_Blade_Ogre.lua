--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 刚鬼 利剑食人魔  (ID: 95515058)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Warrior
-- ATK 2400 | LINK
-- Setcode: 252
--
-- Effect Text:
-- 「刚鬼」怪兽2只以上
-- ①：这张卡的攻击力上升这张卡所连接区的怪兽数量×300。
-- ②：1回合1次，把这张卡所连接区1只自己或者对方的怪兽解放才能发动。这个回合，这张卡在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--剛鬼ザ・ブレード・オーガ
function c95515058.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0xfc),2)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c95515058.atkval)
	c:RegisterEffect(e1)
	--multiatk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c95515058.atkcon)
	e2:SetCost(c95515058.atkcost)
	e2:SetTarget(c95515058.atktg)
	e2:SetOperation(c95515058.atkop)
	c:RegisterEffect(e2)
end
function c95515058.atkval(e,c)
	return c:GetLinkedGroupCount()*300
end
function c95515058.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c95515058.rfilter(c)
	return c:IsReleasable()
end
function c95515058.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local lg=e:GetHandler():GetLinkedGroup()
	if chk==0 then return lg:IsExists(c95515058.rfilter,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=lg:FilterSelect(tp,c95515058.rfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c95515058.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEffectCount(EFFECT_EXTRA_ATTACK)==0 end
end
function c95515058.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
