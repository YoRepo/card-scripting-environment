--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 大日立方体  (ID: 41431329)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Machine
-- Level 3
-- ATK 800 | DEF 800
-- Setcode: 48
--
-- Effect Text:
-- 这张卡被光属性怪兽的同调召唤使用送去墓地的场合，可以从自己卡组选择1张装备魔法卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ヴァイロン・キューブ
function c41431329.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41431329,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c41431329.thcon)
	e1:SetTarget(c41431329.thtg)
	e1:SetOperation(c41431329.thop)
	c:RegisterEffect(e1)
end
function c41431329.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
		and c:GetReasonCard():IsAttribute(ATTRIBUTE_LIGHT)
end
function c41431329.filter(c)
	return c:IsType(TYPE_EQUIP) and c:IsAbleToHand()
end
function c41431329.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c41431329.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c41431329.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c41431329.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
