--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 炎狱妖猴  (ID: 28332833)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 1
-- ATK 200 | DEF 200
-- Setcode: 44
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，可以从自己卡组选择1只守备力200的怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--フレムベル・パウン
function c28332833.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28332833,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c28332833.thcon)
	e1:SetTarget(c28332833.thtg)
	e1:SetOperation(c28332833.thop)
	c:RegisterEffect(e1)
end
function c28332833.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE)
		and e:GetHandler():IsReason(REASON_BATTLE)
end
function c28332833.filter(c)
	return c:IsDefense(200) and c:IsAbleToHand()
end
function c28332833.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c28332833.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c28332833.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c28332833.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
