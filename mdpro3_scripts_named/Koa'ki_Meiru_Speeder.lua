--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 核成高速鸟  (ID: 68809475)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 3
-- ATK 1200 | DEF 2200
-- Setcode: 29
--
-- Effect Text:
-- 这张卡的控制者在每次自己的结束阶段从手卡把1张「核成兽的钢核」送去墓地或把手卡1只机械族怪兽给对方观看。或者都不进行让这张卡破坏。只要这张卡在场上表侧表示存在，自己的抽卡阶段时抽到的卡是「核成兽的钢核
-- 」的场合，可以把那张卡给对方观看让自己再抽1张卡。
--[[ __CARD_HEADER_END__ ]]

--コアキメイル・スピード
function c68809475.initial_effect(c)
	aux.AddCodeList(c,36623431)
	--cost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c68809475.mtcon)
	e1:SetOperation(c68809475.mtop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(68809475,3))
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DRAW)
	e2:SetCondition(c68809475.drcon)
	e2:SetCost(c68809475.drcost)
	e2:SetTarget(c68809475.drtg)
	e2:SetOperation(c68809475.drop)
	c:RegisterEffect(e2)
end
function c68809475.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c68809475.cfilter1(c)
	return c:IsCode(36623431) and c:IsAbleToGraveAsCost()
end
function c68809475.cfilter2(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_MACHINE) and not c:IsPublic()
end
function c68809475.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.HintSelection(Group.FromCards(c))
	local g1=Duel.GetMatchingGroup(c68809475.cfilter1,tp,LOCATION_HAND,0,nil)
	local g2=Duel.GetMatchingGroup(c68809475.cfilter2,tp,LOCATION_HAND,0,nil)
	local select=2
	if g1:GetCount()>0 and g2:GetCount()>0 then
		select=Duel.SelectOption(tp,aux.Stringid(68809475,0),aux.Stringid(68809475,1),aux.Stringid(68809475,2))
	elseif g1:GetCount()>0 then
		select=Duel.SelectOption(tp,aux.Stringid(68809475,0),aux.Stringid(68809475,2))
		if select==1 then select=2 end
	elseif g2:GetCount()>0 then
		select=Duel.SelectOption(tp,aux.Stringid(68809475,1),aux.Stringid(68809475,2))+1
	else
		select=Duel.SelectOption(tp,aux.Stringid(68809475,2))
		select=2
	end
	if select==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=g1:Select(tp,1,1,nil)
		Duel.SendtoGrave(g,REASON_COST)
	elseif select==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local g=g2:Select(tp,1,1,nil)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleHand(tp)
	else
		Duel.Destroy(c,REASON_COST)
	end
end
function c68809475.filter(c)
	return c:IsCode(36623431) and not c:IsPublic()
end
function c68809475.drcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_DRAW
end
function c68809475.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c68809475.filter,1,nil) end
	local g=eg:Filter(c68809475.filter,nil)
	if g:GetCount()==1 then
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleHand(tp)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg=g:Select(tp,1,1,nil)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
	end
end
function c68809475.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c68809475.drop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsFacedown() or not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
