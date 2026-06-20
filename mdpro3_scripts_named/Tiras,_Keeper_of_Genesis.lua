--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 始祖守护者 提拉斯  (ID: 31386180)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Fairy
-- Rank 5
-- ATK 2600 | DEF 1700
--
-- Effect Text:
-- 5星怪兽×2
-- 这张卡的效果只在这张卡持有超量素材的场合适用。
-- ①：场上的这张卡不会被效果破坏。
-- ②：这张卡进行战斗的战斗阶段结束时，以对方场上1张卡为对象发动。那张对方的卡破坏。
-- ③：自己结束阶段发动。这张卡1个超量素材取除。
--[[ __CARD_HEADER_END__ ]]

--始祖の守護者ティラス
function c31386180.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2)
	c:EnableReviveLimit()
	--indestructable by effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetCondition(c31386180.condition)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(31386180,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c31386180.decon)
	e2:SetTarget(c31386180.destg)
	e2:SetOperation(c31386180.desop)
	c:RegisterEffect(e2)
	--remove material
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(31386180,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c31386180.rmcon)
	e3:SetOperation(c31386180.rmop)
	c:RegisterEffect(e3)
end
function c31386180.condition(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c31386180.decon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0
end
function c31386180.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c31386180.desop(e,tp,eg,ep,ev,re,r,rp)
	if not c31386180.condition(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsControler(1-tp) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c31386180.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c31386180.rmop(e,tp,eg,ep,ev,re,r,rp)
	if not c31386180.condition(e) then return end
	local c=e:GetHandler()
	c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
end
