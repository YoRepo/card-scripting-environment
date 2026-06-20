--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 深渊青眼龙  (ID: 64202399)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 8
-- ATK 2500 | DEF 2500
-- Setcode: 14483573
--
-- Effect Text:
-- 这个卡名的①②③的效果1回合各能使用1次，若非自己的场上或墓地有「青眼白龙」存在的场合则不能发动。
-- ①：这张卡特殊召唤的场合才能发动。从卡组把1张仪式魔法卡或「融合」加入手卡。
-- ②：自己结束阶段才能发动。从卡组把1只8星以上的龙族怪兽加入手卡。
-- ③：把墓地的这张卡除外才能发动。自己场上的全部8星以上的龙族怪兽的攻击力上升1000。
--[[ __CARD_HEADER_END__ ]]

--深淵の青眼龍
function c64202399.initial_effect(c)
	aux.AddCodeList(c,89631139)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64202399,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,64202399)
	e1:SetCondition(c64202399.condition)
	e1:SetTarget(c64202399.thtg1)
	e1:SetOperation(c64202399.thop1)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(64202399,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,64202400)
	e2:SetCondition(c64202399.thcon2)
	e2:SetTarget(c64202399.thtg2)
	e2:SetOperation(c64202399.thop2)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(64202399,2))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,64202401)
	e3:SetCondition(c64202399.condition)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c64202399.atktg)
	e3:SetOperation(c64202399.atkop)
	c:RegisterEffect(e3)
end
function c64202399.cfilter(c)
	return (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:IsCode(89631139)
end
function c64202399.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c64202399.cfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil)
end
function c64202399.thfilter1(c)
	return (c:GetType()==TYPE_RITUAL+TYPE_SPELL or c:IsCode(24094653)) and c:IsAbleToHand()
end
function c64202399.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64202399.thfilter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c64202399.thop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c64202399.thfilter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c64202399.thcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and c64202399.condition(e,tp,eg,ep,ev,re,r,rp)
end
function c64202399.thfilter2(c)
	return c:IsLevelAbove(8) and c:IsRace(RACE_DRAGON) and c:IsAbleToHand()
end
function c64202399.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64202399.thfilter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c64202399.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c64202399.thfilter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c64202399.atkfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(8) and c:IsRace(RACE_DRAGON)
end
function c64202399.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64202399.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c64202399.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c64202399.atkfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
