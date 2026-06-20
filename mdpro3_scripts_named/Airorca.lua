--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 空邪鲸  (ID: 84747429)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Sea Serpent
-- Level 3
-- ATK 1400 | DEF 300
--
-- Effect Text:
-- 1回合1次，可以从手卡把1只鱼族·海龙族·水族怪兽从游戏中除外，选择对方场上表侧表示存在的1张卡破坏。那之后，这张卡直到下次的自己的准备阶段时从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--エアジャチ
local s,id,o=GetID()
function c84747429.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84747429,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c84747429.descost)
	e1:SetTarget(c84747429.destg)
	e1:SetOperation(c84747429.desop)
	c:RegisterEffect(e1)
end
function c84747429.cfilter(c)
	return c:IsRace(RACE_FISH+RACE_SEASERPENT+RACE_AQUA) and c:IsAbleToRemoveAsCost()
end
function c84747429.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84747429.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c84747429.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c84747429.filter(c)
	return c:IsFaceup()
end
function c84747429.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c84747429.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c84747429.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c84747429.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c84747429.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 and c:IsRelateToEffect(e) then
		Duel.BreakEffect()
		if Duel.Remove(c,0,REASON_EFFECT+REASON_TEMPORARY)~=0 and c:GetOriginalCode()==id then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
			e1:SetCountLimit(1)
			e1:SetLabelObject(c)
			e1:SetCondition(c84747429.retcon)
			e1:SetOperation(c84747429.retop)
			e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c84747429.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c84747429.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
