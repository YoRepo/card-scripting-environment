--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 光子栗子  (ID: 35112613)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level 1
-- ATK 300 | DEF 200
-- Setcode: 85
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：把这张卡从手卡送去墓地，支付2000基本分才能发动。这个回合，自己受到的全部伤害变成0。这个效果在对方回合也能发动。
-- ②：这张卡在墓地存在的场合，从手卡把「光子栗子」以外的1只「光子」怪兽送去墓地才能发动。墓地的这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--クリフォトン
function c35112613.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(35112613,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c35112613.cost)
	e1:SetOperation(c35112613.operation)
	c:RegisterEffect(e1)
	--salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(35112613,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,35112613)
	e2:SetCost(c35112613.thcost)
	e2:SetTarget(c35112613.thtg)
	e2:SetOperation(c35112613.thop)
	c:RegisterEffect(e2)
end
function c35112613.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) and e:GetHandler():IsAbleToGraveAsCost() end
	Duel.PayLPCost(tp,2000)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c35112613.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c35112613.cfilter(c)
	return c:IsSetCard(0x55) and c:IsType(TYPE_MONSTER) and not c:IsCode(35112613) and c:IsAbleToGraveAsCost()
end
function c35112613.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c35112613.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c35112613.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c35112613.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c35112613.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
