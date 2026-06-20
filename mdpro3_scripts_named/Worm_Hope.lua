--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 霍普异虫  (ID: 11159464)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Reptile
-- Level 1
-- ATK 800 | DEF 1500
-- Setcode: 8323134
--
-- Effect Text:
-- 反转：被对方怪兽的攻击反转的场合，从自己卡组抽1张卡。此外，这张卡从场上送去墓地时，自己把1张手卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ワーム・ホープ
function c11159464.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FLIP+EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetTarget(c11159464.drtg)
	e1:SetOperation(c11159464.drop)
	c:RegisterEffect(e1)
	--discard
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11159464,0))
	e2:SetCategory(CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c11159464.tgcon)
	e2:SetTarget(c11159464.tgtg)
	e2:SetOperation(c11159464.tgop)
	c:RegisterEffect(e2)
end
function c11159464.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.GetCurrentPhase()==PHASE_DAMAGE and e:GetHandler()==Duel.GetAttackTarget() then
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	end
end
function c11159464.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentPhase()==PHASE_DAMAGE and e:GetHandler()==Duel.GetAttackTarget() then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c11159464.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c11159464.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
end
function c11159464.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT,nil)
end
