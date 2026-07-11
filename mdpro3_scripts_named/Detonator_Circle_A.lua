--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Detonator Circle "A"  (ID: 20985997)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Destroy 1 face-up monster with an A-Counter(s), and then inflict 1000 damage to each player.
--[[ __CARD_HEADER_END__ ]]

--デストラクト・サークル－A
function c20985997.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c20985997.target)
	e1:SetOperation(c20985997.activate)
	c:RegisterEffect(e1)
end
function c20985997.filter(c)
	return c:GetCounter(0x100e)>0
end
function c20985997.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20985997.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20985997.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c20985997.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,1000)
end
function c20985997.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:GetCounter(0x100e)>0 and tc:IsRelateToEffect(e) then
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			Duel.Damage(1-tp,1000,REASON_EFFECT,true)
			Duel.Damage(tp,1000,REASON_EFFECT,true)
			Duel.RDComplete()
		end
	end
end
