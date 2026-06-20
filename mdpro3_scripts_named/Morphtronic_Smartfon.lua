--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 变形斗士·智能机  (ID: 15521027)
-- Type: Monster / Effect / Tuner / SpecialSummon
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- ATK 100 | DEF 100
-- Setcode: 38
--
-- Effect Text:
-- 这张卡不能通常召唤。从自己墓地把1只「变形斗士」怪兽除外的场合可以特殊召唤。
-- ①：这张卡得到表示形式的以下效果。
-- ●攻击表示：1回合1次，自己主要阶段才能发动。掷1次骰子，把出现的数目数量的卡从自己卡组上面翻开。从那之中把1张「变形斗士」卡加入手卡，剩余回到卡组。
-- ●守备表示：1回合1次，自己主要阶段才能发动。掷1次骰子，把出现的数目数量的卡从自己卡组上面确认，用喜欢的顺序回到卡组上面或下面。
--[[ __CARD_HEADER_END__ ]]

--D・スマホン
function c15521027.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15521027,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c15521027.spcon)
	e1:SetTarget(c15521027.sptg)
	e1:SetOperation(c15521027.spop)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(15521027,1))
	e2:SetCategory(CATEGORY_DICE+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c15521027.cona)
	e2:SetTarget(c15521027.tga)
	e2:SetOperation(c15521027.opa)
	c:RegisterEffect(e2)
	--sort deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(15521027,2))
	e3:SetCategory(CATEGORY_DICE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c15521027.cond)
	e3:SetTarget(c15521027.tgd)
	e3:SetOperation(c15521027.opd)
	c:RegisterEffect(e3)
end
function c15521027.spfilter(c)
	return c:IsSetCard(0x26) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c15521027.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c15521027.spfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c15521027.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c15521027.spfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c15521027.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Remove(g,POS_FACEUP,REASON_SPSUMMON)
end
function c15521027.cona(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c15521027.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c15521027.filter(c)
	return c:IsSetCard(0x26) and c:IsAbleToHand()
end
function c15521027.opa(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local dc=Duel.TossDice(tp,1)
	Duel.ConfirmDecktop(tp,dc)
	local dg=Duel.GetDecktopGroup(tp,dc)
	local g=dg:Filter(c15521027.filter,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
	Duel.ShuffleDeck(tp)
end
function c15521027.cond(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDefensePos()
end
function c15521027.tgd(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c15521027.opd(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local dc=Duel.TossDice(tp,1)
	local g=Duel.GetDecktopGroup(tp,dc)
	local ct=g:GetCount()
	Duel.ConfirmCards(tp,g)
	local op=Duel.SelectOption(tp,aux.Stringid(15521027,3),aux.Stringid(15521027,4))
	Duel.SortDecktop(tp,tp,ct)
	if op==0 then return end
	for i=1,ct do
		local tg=Duel.GetDecktopGroup(tp,1)
		Duel.MoveSequence(tg:GetFirst(),SEQ_DECKBOTTOM)
	end
end
