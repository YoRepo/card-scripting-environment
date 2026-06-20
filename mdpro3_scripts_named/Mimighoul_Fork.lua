--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 迷拟宝箱鬼·岔路  (ID: 19338434)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 439
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：以对方场上1只里侧表示怪兽为对象才能发动。对方从以下效果选1个，自己让那个效果适用。
-- ●作为对象的怪兽变成表侧攻击表示或表侧守备表示。
-- ●作为对象的怪兽送去墓地。那之后，这个效果送去墓地的怪兽的持有者抽2张。
-- ②：把墓地的这张卡除外才能发动。从卡组把1张「迷拟宝箱鬼·岔路」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ミミグル・フォーク
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,3))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id+o)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
end
function s.filter(c)
	local p=c:GetOwner()
	return c:IsPosition(POS_FACEDOWN_DEFENSE) and (c:IsCanChangePosition() or (c:IsAbleToGrave() and Duel.IsPlayerCanDraw(p,2)))
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsPosition(POS_FACEDOWN_DEFENSE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWNDEFENSE)
	local g=Duel.SelectTarget(tp,s.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local p=tc:GetOwner()
	local a=tc:IsCanChangePosition()
	local b=tc:IsAbleToGrave() and Duel.IsPlayerCanDraw(p,2)
	local op=aux.SelectFromOptions(1-tp,{a,aux.Stringid(id,1)},{b,aux.Stringid(id,2)})
	if op==1 then
		local pos1=0
		if not tc:IsPosition(POS_FACEUP_ATTACK) then pos1=pos1+POS_FACEUP_ATTACK end
		if not tc:IsPosition(POS_FACEUP_DEFENSE) then pos1=pos1+POS_FACEUP_DEFENSE end
		local pos=Duel.SelectPosition(tp,tc,pos1)
		Duel.ChangePosition(tc,pos)
	else
		Duel.SendtoGrave(tc,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.Draw(p,2,REASON_EFFECT)
	end
end
function s.thfilter(c)
	return c:IsCode(id) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
