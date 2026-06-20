--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 灵魂的据所  (ID: 9553721)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「灵魂的据所」的②的效果1回合只能使用1次。
-- ①：自己场上的灵魂怪兽的攻击力·守备力上升500。
-- ②：自己场上的表侧表示的风属性怪兽回到自己手卡的场合才能发动。从卡组把1只灵魂怪兽或者1张仪式魔法卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--霊魂の拠所
function c9553721.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_SPIRIT))
	e2:SetValue(500)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--search
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(9553721,0))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_TO_HAND)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1,9553721)
	e4:SetCondition(c9553721.thcon)
	e4:SetTarget(c9553721.thtg)
	e4:SetOperation(c9553721.thop)
	c:RegisterEffect(e4)
end
c9553721.has_text_type=TYPE_SPIRIT
function c9553721.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and bit.band(c:GetPreviousAttributeOnField(),ATTRIBUTE_WIND)~=0
		and c:IsPreviousPosition(POS_FACEUP) and c:IsControler(tp)
end
function c9553721.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c9553721.cfilter,1,nil,tp)
end
function c9553721.thfilter(c)
	return (c:IsType(TYPE_SPIRIT) or c:GetType()==0x82) and c:IsAbleToHand()
end
function c9553721.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c9553721.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c9553721.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c9553721.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
