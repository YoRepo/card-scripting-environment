--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Kagemusha of the Six Samurai  (ID: 1498130)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Warrior
-- Level: 2
-- ATK 400 | DEF 1800
-- Setcode: 0x103d
-- Scope: OCG / TCG
--
-- Effect Text:
-- When exactly 1 "Six Samurai" monster you control is targeted by a card or effect (Quick Effect): You
-- can activate this effect; that card/effect now targets this face-up card on the field, instead.
--[[ __CARD_HEADER_END__ ]]

--六武衆の影武者
function c1498130.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1498130,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c1498130.tgcon)
	e1:SetOperation(c1498130.tgop)
	c:RegisterEffect(e1)
end
function c1498130.tgcon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	local c=e:GetHandler()
	if tc==c or tc:IsControler(1-tp) or tc:IsFacedown() or not tc:IsLocation(LOCATION_MZONE) or not tc:IsSetCard(0x103d) then return false end
	return Duel.CheckChainTarget(ev,c)
end
function c1498130.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local g=Group.CreateGroup()
		g:AddCard(c)
		Duel.ChangeTargetCard(ev,g)
	end
end
