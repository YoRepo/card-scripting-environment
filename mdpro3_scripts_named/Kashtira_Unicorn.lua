--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 俱舍怒威族·独角兽  (ID: 68304193)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Psychic
-- Level 7
-- ATK 2500 | DEF 2100
-- Setcode: 393
--
-- Effect Text:
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：自己场上没有怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：自己主要阶段才能发动。从卡组把1张「俱舍怒威族」魔法卡加入手卡。
-- ③：这张卡的攻击宣言时或者对方把怪兽的效果发动的场合才能发动。把对方的额外卡组确认，选那之内的1只怪兽里侧表示除外。
--[[ __CARD_HEADER_END__ ]]

--クシャトリラ・ユニコーン
function c68304193.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68304193,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c68304193.spcon)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(68304193,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,68304193)
	e2:SetTarget(c68304193.thtg)
	e2:SetOperation(c68304193.thop)
	c:RegisterEffect(e2)
	--remove when attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(68304193,2))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetCountLimit(1,68304194)
	e3:SetTarget(c68304193.rmtg)
	e3:SetOperation(c68304193.rmop)
	c:RegisterEffect(e3)
	--remove when chaining
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(68304193,2))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,68304194)
	e4:SetCondition(c68304193.rmcon)
	e4:SetTarget(c68304193.rmtg2)
	e4:SetOperation(c68304193.rmop)
	c:RegisterEffect(e4)
end
function c68304193.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c68304193.thfilter(c)
	return c:IsSetCard(0x189) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c68304193.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c68304193.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c68304193.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c68304193.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c68304193.rmfilter(c,tp)
	return c:IsAbleToRemove(tp,POS_FACEDOWN)
end
function c68304193.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c68304193.rmfilter,tp,0,LOCATION_EXTRA,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_EXTRA)
end
function c68304193.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
	Duel.ConfirmCards(tp,g,true)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=g:FilterSelect(tp,c68304193.rmfilter,1,1,nil,tp)
	if #sg>0 then
		Duel.Remove(sg,POS_FACEDOWN,REASON_EFFECT)
	end
	Duel.ShuffleExtra(1-tp)
end
function c68304193.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsActiveType(TYPE_MONSTER)
end
function c68304193.rmtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return rp==1-tp and Duel.IsExistingMatchingCard(c68304193.rmfilter,tp,0,LOCATION_EXTRA,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_EXTRA)
end
