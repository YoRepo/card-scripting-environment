--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Dogmatika Nation  (ID: 65589010)
-- Type: Spell / Field
-- Setcode: 0x145
-- Scope: OCG / TCG
--
-- Effect Text:
-- Neither player can target "Dogmatika" monsters you control with effects of monsters that were
-- Special Summoned from the Extra Deck.
-- You can only use each of the following effects of "Dogmatika Nation" once per turn.
-- After damage calculation, if your "Dogmatika" monster battled an opponent's monster: You can destroy
-- that opponent's monster.
-- If this face-up card in the Field Zone is destroyed by an opponent's card effect: You can have each
-- player send 1 monster from their Extra Deck to the GY.
--[[ __CARD_HEADER_END__ ]]

--教導国家ドラグマ
function c65589010.initial_effect(c)
	--activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_FZONE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c65589010.eftg)
	e1:SetValue(c65589010.efilter)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(65589010,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,65589010)
	e2:SetCondition(c65589010.descon)
	e2:SetTarget(c65589010.destg)
	e2:SetOperation(c65589010.desop)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(65589010,1))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,65589011)
	e3:SetCondition(c65589010.tgcon)
	e3:SetTarget(c65589010.tgtg)
	e3:SetOperation(c65589010.tgop)
	c:RegisterEffect(e3)
end
function c65589010.eftg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x145)
end
function c65589010.efilter(e,re,rp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSummonLocation(LOCATION_EXTRA) and re:GetActivateLocation()==LOCATION_MZONE
end
function c65589010.descon(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	if not bc then return false end
	if not ac:IsControler(tp) then ac,bc=bc,ac end
	e:SetLabelObject(bc)
	return ac:IsFaceup() and ac:IsControler(tp) and ac:IsSetCard(0x145) and bc:IsControler(1-tp)
end
function c65589010.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetLabelObject()
	if not bc then return false end
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c65589010.desop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc and bc:IsRelateToBattle() and bc:IsControler(1-tp) then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
function c65589010.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousLocation(LOCATION_FZONE) and c:IsPreviousControler(tp)
		and c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp
end
function c65589010.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_EXTRA,0,nil)
	local g2=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0,LOCATION_EXTRA,nil)
	if chk==0 then return g:GetCount()>0 and g2:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,2,PLAYER_ALL,LOCATION_EXTRA)
end
function c65589010.tgop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_EXTRA,0,1,nil)
		or not Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_EXTRA,1,nil) then return end
	local p=Duel.GetTurnPlayer()
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,p,LOCATION_EXTRA,0,nil)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TOGRAVE)
	local sg=g:Select(p,1,1,nil)
	if sg:GetCount()>0 then
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
	local g2=Duel.GetMatchingGroup(Card.IsAbleToGrave,p,0,LOCATION_EXTRA,nil)
	Duel.Hint(HINT_SELECTMSG,1-p,HINTMSG_TOGRAVE)
	local sg2=g2:Select(1-p,1,1,nil)
	if sg2:GetCount()>0 then
		Duel.SendtoGrave(sg2,REASON_EFFECT)
	end
end
