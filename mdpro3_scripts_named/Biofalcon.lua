--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 生化猎鹰  (ID: 74130411)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1700 | DEF 1200
--
-- Effect Text:
-- 这张卡在场上表侧表示存在的场合自己场上存在的机械族怪兽被战斗破坏送去墓地时，可以从自己卡组把1只攻击力1000以下的机械族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--バイオファルコン
function c74130411.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74130411,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c74130411.thcon)
	e1:SetTarget(c74130411.thtg)
	e1:SetOperation(c74130411.thop)
	c:RegisterEffect(e1)
end
function c74130411.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsLocation(LOCATION_GRAVE) and c:IsRace(RACE_MACHINE) and c:IsReason(REASON_BATTLE)
end
function c74130411.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c74130411.cfilter,1,nil,tp)
end
function c74130411.filter(c)
	return c:IsAttackBelow(1000) and c:IsRace(RACE_MACHINE) and c:IsAbleToHand()
end
function c74130411.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c74130411.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c74130411.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c74130411.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
