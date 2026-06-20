--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 影灵衣大魔道士  (ID: 27796375)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level 4
-- ATK 1500 | DEF 800
-- Setcode: 180
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：这张卡被效果解放的场合才能发动。从卡组把1只魔法师族「影灵衣」仪式怪兽加入手卡。
-- ②：这张卡被除外的场合才能发动。从卡组把「影灵衣大魔道士」以外的1只「影灵衣」怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--影霊衣の大魔道士
function c27796375.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27796375,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_RELEASE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,27796375)
	e1:SetCondition(c27796375.thcon)
	e1:SetCost(c27796375.cost)
	e1:SetTarget(c27796375.thtg)
	e1:SetOperation(c27796375.thop)
	c:RegisterEffect(e1)
	--tograve
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27796375,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,27796375)
	e2:SetCost(c27796375.cost)
	e2:SetTarget(c27796375.tgtg)
	e2:SetOperation(c27796375.tgop)
	c:RegisterEffect(e2)
end
function c27796375.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c27796375.thcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end
function c27796375.thfilter(c)
	return c:IsSetCard(0xb4) and c:IsType(TYPE_RITUAL) and c:IsRace(RACE_SPELLCASTER) and c:IsAbleToHand()
end
function c27796375.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c27796375.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c27796375.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c27796375.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c27796375.tgfilter(c)
	return c:IsSetCard(0xb4) and not c:IsCode(27796375) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c27796375.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c27796375.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c27796375.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c27796375.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
