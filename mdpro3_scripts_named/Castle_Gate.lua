--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 城堡之门  (ID: 36931229)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 6
-- ATK 0 | DEF 2400
--
-- Effect Text:
-- ①：这张卡不会被战斗破坏。
-- ②：1回合1次，这张卡在场上攻击表示存在的场合，把自己场上1只5星以下的怪兽解放才能发动。给与对方解放的怪兽的原本攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--キャッスル・ゲート
function c36931229.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(36931229,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c36931229.condition)
	e2:SetCost(c36931229.cost)
	e2:SetTarget(c36931229.target)
	e2:SetOperation(c36931229.operation)
	c:RegisterEffect(e2)
end
function c36931229.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c36931229.filter(c)
	return c:IsLevelBelow(5) and c:GetTextAttack()>0
end
function c36931229.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c36931229.filter,1,nil) end
	local sg=Duel.SelectReleaseGroup(tp,c36931229.filter,1,1,nil)
	e:SetLabel(sg:GetFirst():GetTextAttack())
	Duel.Release(sg,REASON_COST)
end
function c36931229.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c36931229.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
