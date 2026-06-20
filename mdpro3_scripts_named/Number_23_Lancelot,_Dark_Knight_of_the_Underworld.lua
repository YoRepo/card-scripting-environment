--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: No.23 冥界的灵骑士 兰斯洛特  (ID: 66547759)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Zombie
-- Rank 8
-- ATK 2000 | DEF 1500
-- Setcode: 11010120
--
-- Effect Text:
-- 8星怪兽×2
-- ①：持有超量素材的这张卡可以直接攻击。
-- ②：这张卡给与对方战斗伤害时，以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽破坏。
-- ③：1回合1次，这张卡以外的怪兽的效果·魔法·陷阱卡发动时，把这张卡1个超量素材取除发动。那个发动无效。
--[[ __CARD_HEADER_END__ ]]

--No.23 冥界の霊騎士ランスロット
function c66547759.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,2)
	c:EnableReviveLimit()
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c66547759.dacon)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66547759,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c66547759.descon)
	e2:SetTarget(c66547759.destg)
	e2:SetOperation(c66547759.desop)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(66547759,1))
	e3:SetCategory(CATEGORY_NEGATE)
	e3:SetType(EFFECT_TYPE_QUICK_F)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c66547759.discon)
	e3:SetCost(c66547759.discost)
	e3:SetTarget(c66547759.distg)
	e3:SetOperation(c66547759.disop)
	c:RegisterEffect(e3)
end
aux.xyz_number[66547759]=23
function c66547759.dacon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c66547759.descon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c66547759.filter(c)
	return c:IsFaceup()
end
function c66547759.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c66547759.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c66547759.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c66547759.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c66547759.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c66547759.discon(e,tp,eg,ep,ev,re,r,rp)
	return (re:IsHasType(EFFECT_TYPE_ACTIVATE) or re:IsActiveType(TYPE_MONSTER))
		and re:GetHandler()~=e:GetHandler()
end
function c66547759.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c66547759.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c66547759.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentChain()==ev+1 then
		Duel.NegateActivation(ev)
	end
end
