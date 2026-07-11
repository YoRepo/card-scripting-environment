--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Numbing Grub in the Ice Barrier  (ID: 92065772)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Insect
-- Level: 4
-- ATK 1300 | DEF 1800
-- Setcode: 0x2f
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned, select 1 unused Main Monster Zone.
-- While this card is face-up on the field, that selected Main Monster Zone cannot be used.
--[[ __CARD_HEADER_END__ ]]

--氷結界に住む魔酔虫
function c92065772.initial_effect(c)
	--dis field
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92065772,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c92065772.target)
	e1:SetOperation(c92065772.operation)
	c:RegisterEffect(e1)
end
function c92065772.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:SetLabel(0)
	if Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0)<=0
		and Duel.GetLocationCount(1-tp,LOCATION_MZONE,PLAYER_NONE,0)<=0 then return end
	local dis1=Duel.SelectDisableField(tp,1,LOCATION_MZONE,LOCATION_MZONE,0xe000e0)
	e:SetLabel(dis1)
end
function c92065772.operation(e,tp,eg,ep,ev,re,r,rp)
	local zone=e:GetLabel()
	if tp==1 then
		zone=((zone&0xffff)<<16)|((zone>>16)&0xffff)
	end
	local c=e:GetHandler()
	--disable field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_DISABLE_FIELD)
	e2:SetValue(zone)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e2)
end
