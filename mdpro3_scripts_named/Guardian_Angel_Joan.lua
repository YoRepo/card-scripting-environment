--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Guardian Angel Joan  (ID: 68007326)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 7
-- ATK 2800 | DEF 2000
-- Setcode: 0x52
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card destroys a monster by battle and sends it to the GY: Gain LP equal to that monster's
-- original ATK in the GY.
--[[ __CARD_HEADER_END__ ]]

--守護天使 ジャンヌ
function c68007326.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68007326,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c68007326.reccon)
	e1:SetTarget(c68007326.rectg)
	e1:SetOperation(c68007326.recop)
	c:RegisterEffect(e1)
end
function c68007326.reccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE)
end
function c68007326.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	local rec=bc:GetBaseAttack()
	if rec<0 then rec=0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c68007326.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
