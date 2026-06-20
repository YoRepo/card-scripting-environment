--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 交换祭司  (ID: 30968774)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Cyberse
-- Level 2
-- ATK 500 | DEF 1000
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡作为连接素材送去墓地的场合才能发动。这张卡为连接素材的连接怪兽的攻击力下降500。那之后，自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--スワップリースト
function c30968774.initial_effect(c)
	--reduce atk and draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30968774,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCountLimit(1,30968774)
	e1:SetCondition(c30968774.drcon)
	e1:SetTarget(c30968774.drtg)
	e1:SetOperation(c30968774.drop)
	c:RegisterEffect(e1)
	aux.CreateMaterialReasonCardRelation(c,e1)
end
function c30968774.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_LINK
end
function c30968774.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local rc=e:GetHandler():GetReasonCard()
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and rc:IsRelateToEffect(e) end
	Duel.SetTargetCard(rc)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c30968774.drop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=Duel.GetFirstTarget()
	if rc:IsRelateToChain() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		rc:RegisterEffect(e1)
		Duel.BreakEffect()
	end
	Duel.Draw(tp,1,REASON_EFFECT)
end
