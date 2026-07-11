--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Turbo Cannon  (ID: 13574687)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Machine
-- Level: 3
-- ATK 0 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Turbo Rocket" + 1 or more non-Tuner monsters
-- Once per turn, you can destroy 1 face-up monster on the field and inflict damage to its controller
-- equal to half of its ATK.
--[[ __CARD_HEADER_END__ ]]

--ワンショット・キャノン
function c13574687.initial_effect(c)
	aux.AddMaterialCodeList(c,6142213)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsCode,6142213),aux.NonTuner(nil),1,1)
	c:EnableReviveLimit()
	--destroy & damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13574687,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c13574687.target)
	e1:SetOperation(c13574687.operation)
	c:RegisterEffect(e1)
end
function c13574687.filter(c)
	return c:IsFaceup()
end
function c13574687.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c13574687.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13574687.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c13574687.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,g:GetFirst():GetControler(),math.floor(g:GetFirst():GetAttack()/2))
end
function c13574687.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local dam=math.floor(tc:GetAttack()/2)
		local p=tc:GetControler()
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.Damage(p,dam,REASON_EFFECT)
		end
	end
end
