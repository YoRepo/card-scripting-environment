--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: No.14 强欲之死神犬  (ID: 21313376)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Beast
-- Rank 5
-- ATK 2500 | DEF 1500
-- Setcode: 72
--
-- Effect Text:
-- 5星怪兽×2
-- ①：只要这张卡在怪兽区域存在，对方的效果发生的对自己的效果伤害由对方代受。
-- ②：这张卡战斗破坏对方怪兽送去墓地时，把这张卡1个超量素材取除才能发动。持有破坏的那只怪兽的原本攻击力以下的攻击力的场上的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--No.14 強欲のサラメーヤ
function c21313376.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2)
	c:EnableReviveLimit()
	--reflect damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c21313376.refcon)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCondition(aux.bdogcon)
	e2:SetCost(c21313376.descost)
	e2:SetTarget(c21313376.destg)
	e2:SetOperation(c21313376.desop)
	c:RegisterEffect(e2)
end
aux.xyz_number[21313376]=14
function c21313376.refcon(e,re,val,r,rp,rc)
	return bit.band(r,REASON_EFFECT)~=0 and rp==1-e:GetHandlerPlayer()
end
function c21313376.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c21313376.filter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk)
end
function c21313376.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local atk=e:GetHandler():GetBattleTarget():GetBaseAttack()
	if chk==0 then return Duel.IsExistingMatchingCard(c21313376.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,atk) end
	local g=Duel.GetMatchingGroup(c21313376.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,atk)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c21313376.desop(e,tp,eg,ep,ev,re,r,rp)
	local atk=e:GetHandler():GetBattleTarget():GetBaseAttack()
	local g=Duel.GetMatchingGroup(c21313376.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,atk)
	Duel.Destroy(g,REASON_EFFECT)
end
