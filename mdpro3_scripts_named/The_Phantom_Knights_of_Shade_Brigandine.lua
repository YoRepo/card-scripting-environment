--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: The Phantom Knights of Shade Brigandine  (ID: 98827725)
-- Type: Trap
-- Setcode: 0x10db
-- Scope: OCG / TCG
--
-- Effect Text:
-- Special Summon this card in Defense Position as a Normal Monster (Warrior/DARK/Level 4/ATK 0/DEF
-- 300) (this card is NOT treated as a Trap).
-- If you have no Traps in your GY, you can activate this card the turn it was Set.
-- You can only activate 1 "The Phantom Knights of Shade Brigandine" per turn.
--[[ __CARD_HEADER_END__ ]]

--幻影騎士団シェード・ブリガンダイン
function c98827725.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,98827725+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c98827725.target)
	e1:SetOperation(c98827725.activate)
	c:RegisterEffect(e1)
	--act in set turn
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98827725,0))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCondition(c98827725.actcon)
	c:RegisterEffect(e2)
end
function c98827725.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,98827725,0x10db,TYPES_NORMAL_TRAP_MONSTER,0,300,4,RACE_WARRIOR,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c98827725.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.IsPlayerCanSpecialSummonMonster(tp,98827725,0x10db,TYPES_NORMAL_TRAP_MONSTER,0,300,4,RACE_WARRIOR,ATTRIBUTE_DARK) then
		c:AddMonsterAttribute(TYPE_NORMAL)
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_DEFENSE)
	end
end
function c98827725.actcon(e)
	return not Duel.IsExistingMatchingCard(Card.IsType,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,TYPE_TRAP)
end
