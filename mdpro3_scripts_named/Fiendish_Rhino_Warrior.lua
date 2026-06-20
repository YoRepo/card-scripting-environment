--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 魔犀族战士  (ID: 81035362)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level 3
-- ATK 1400 | DEF 900
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，「魔犀族战士」以外的自己场上的恶魔族怪兽不会被战斗·效果破坏。
-- ②：这张卡被送去墓地的场合才能发动。从卡组把「魔犀族战士」以外的1只恶魔族怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--魔サイの戦士
function c81035362.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c81035362.indtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(81035362,0))
	e3:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DECKDES)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,81035362)
	e3:SetTarget(c81035362.tgtg)
	e3:SetOperation(c81035362.tgop)
	c:RegisterEffect(e3)
end
function c81035362.indtg(e,c)
	return c:IsRace(RACE_FIEND) and not c:IsCode(81035362)
end
function c81035362.tgfilter(c)
	return c:IsRace(RACE_FIEND) and not c:IsCode(81035362) and c:IsAbleToGrave()
end
function c81035362.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81035362.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c81035362.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c81035362.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
