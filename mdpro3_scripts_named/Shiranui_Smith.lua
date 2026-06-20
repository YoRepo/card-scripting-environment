--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 不知火的锻师  (ID: 62038047)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Zombie
-- Level 4
-- ATK 1000 | DEF 0
-- Setcode: 217
--
-- Effect Text:
-- 「不知火的锻师」的①的效果1回合只能使用1次。
-- ①：场上的这张卡作为同调素材送去墓地的场合才能发动。从卡组把「不知火的锻师」以外的1张「不知火」卡加入手卡。
-- ②：这张卡被除外的场合才能发动。这个回合，自己的不死族怪兽不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--不知火の鍛師
function c62038047.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62038047,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,62038047)
	e1:SetCondition(c62038047.thcon)
	e1:SetTarget(c62038047.thtg)
	e1:SetOperation(c62038047.thop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(62038047,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetOperation(c62038047.operation)
	c:RegisterEffect(e2)
end
function c62038047.filter(c)
	return c:IsSetCard(0xd9) and not c:IsCode(62038047) and c:IsAbleToHand()
end
function c62038047.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and c:IsPreviousLocation(LOCATION_ONFIELD) and r==REASON_SYNCHRO
end
function c62038047.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c62038047.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c62038047.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c62038047.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c62038047.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c62038047.target)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
end
function c62038047.target(e,c)
	return c:IsRace(RACE_ZOMBIE)
end
