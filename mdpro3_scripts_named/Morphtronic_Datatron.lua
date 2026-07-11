--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Morphtronic Datatron  (ID: 66331855)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 3
-- ATK 1200 | DEF 600
-- Setcode: 0x26
-- Scope: OCG / TCG
--
-- Effect Text:
-- ● While in Attack Position: Once per turn, you can Tribute 1 monster to inflict 600 damage to your
-- opponent.
-- ● While in Defense Position: Once per turn, you can inflict 300 damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--D・チャッカン
function c66331855.initial_effect(c)
	--damagea
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66331855,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c66331855.cona)
	e1:SetCost(c66331855.costa)
	e1:SetTarget(c66331855.tga)
	e1:SetOperation(c66331855.op)
	c:RegisterEffect(e1)
	--damaged
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(66331855,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c66331855.cond)
	e2:SetTarget(c66331855.tgd)
	e2:SetOperation(c66331855.op)
	c:RegisterEffect(e2)
end
function c66331855.cona(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsDisabled() and e:GetHandler():IsAttackPos()
end
function c66331855.cond(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsDisabled() and e:GetHandler():IsDefensePos()
end
function c66331855.costa(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,aux.TRUE,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,aux.TRUE,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c66331855.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(600)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,600)
end
function c66331855.tgd(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(300)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end
function c66331855.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
