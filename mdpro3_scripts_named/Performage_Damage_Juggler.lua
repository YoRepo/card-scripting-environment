--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 娱乐法师 伤害杂耍人  (ID: 68819554)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1500 | DEF 1000
-- Setcode: 198
--
-- Effect Text:
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：给与自己伤害的魔法·陷阱·怪兽的效果发动时，把这张卡从手卡丢弃才能发动。那个发动无效并破坏。
-- ②：自己·对方的战斗阶段，把这张卡从手卡丢弃才能发动。这个回合，自己受到的战斗伤害只有1次变成0。
-- ③：把墓地的这张卡除外才能发动。从卡组把「娱乐法师 伤害杂耍人」以外的1只「娱乐法师」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--Emダメージ・ジャグラー
function c68819554.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68819554,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c68819554.negcon)
	e1:SetCost(c68819554.effcost)
	e1:SetTarget(c68819554.negtg)
	e1:SetOperation(c68819554.negop)
	c:RegisterEffect(e1)
	--reduce damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(68819554,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c68819554.damcon)
	e2:SetCost(c68819554.effcost)
	e2:SetOperation(c68819554.damop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,68819554)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c68819554.thtg)
	e3:SetOperation(c68819554.thop)
	c:RegisterEffect(e3)
end
function c68819554.effcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c68819554.negcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainNegatable(ev) and aux.damcon1(e,tp,eg,ep,ev,re,r,rp)
end
function c68819554.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsDestructable() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c68819554.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c68819554.damcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE_STEP)
end
function c68819554.damop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c68819554.thfilter(c)
	return c:IsSetCard(0xc6) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and not c:IsCode(68819554)
end
function c68819554.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c68819554.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c68819554.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c68819554.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
