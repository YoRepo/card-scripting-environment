--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 魔女术的创造  (ID: 57916305)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 296
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：从卡组把1只「魔女术」怪兽加入手卡。
-- ②：这张卡在墓地存在，自己场上有「魔女术」怪兽存在的场合，自己结束阶段才能发动。这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ウィッチクラフト・クリエイション
function c57916305.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,57916305)
	e1:SetTarget(c57916305.target)
	e1:SetOperation(c57916305.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(57916305,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1,57916305)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c57916305.thcon)
	e2:SetTarget(c57916305.thtg)
	e2:SetOperation(c57916305.thop)
	c:RegisterEffect(e2)
end
function c57916305.filter(c)
	return c:IsSetCard(0x128) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c57916305.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c57916305.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c57916305.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c57916305.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c57916305.rccfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x128)
end
function c57916305.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(c57916305.rccfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c57916305.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c57916305.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
