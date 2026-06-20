--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 堇菜之魔女  (ID: 62379337)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 1100 | DEF 1200
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，从自己卡组把1只守备力1500以下的植物族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--バイオレット・ウィッチ
function c62379337.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62379337,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c62379337.condition)
	e1:SetTarget(c62379337.target)
	e1:SetOperation(c62379337.operation)
	c:RegisterEffect(e1)
end
function c62379337.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c62379337.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c62379337.filter(c)
	return c:IsDefenseBelow(1500) and c:IsRace(RACE_PLANT) and c:IsAbleToHand()
end
function c62379337.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c62379337.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
