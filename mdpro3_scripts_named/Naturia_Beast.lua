--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 自然兽  (ID: 33198837)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Beast
-- Level 5
-- ATK 2200 | DEF 1700
-- Setcode: 42
--
-- Effect Text:
-- 地属性调整＋调整以外的地属性怪兽1只以上
-- ①：魔法卡发动时，从自己卡组上面把2张卡送去墓地才能发动。这张卡在场上表侧表示存在的场合，那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・ビースト
function c33198837.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c33198837.synfilter,aux.NonTuner(c33198837.synfilter),1)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33198837,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c33198837.discon)
	e1:SetCost(c33198837.discost)
	e1:SetTarget(c33198837.distg)
	e1:SetOperation(c33198837.disop)
	c:RegisterEffect(e1)
end
function c33198837.synfilter(c)
	return c:IsAttribute(ATTRIBUTE_EARTH)
end
function c33198837.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and Duel.IsChainNegatable(ev)
end
function c33198837.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,2) end
	Duel.DiscardDeck(tp,2,REASON_COST)
end
function c33198837.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c33198837.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
