--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 痛苦油漆工  (ID: 21620076)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Zombie
-- Level 2
-- ATK 400 | DEF 200
--
-- Effect Text:
-- 这张卡的卡名只要在场上表侧表示存在当作「僵尸带菌者」使用。此外，1回合1次，选择这张卡以外的自己场上最多2只不死族怪兽才能发动。选择的怪兽的等级直到结束阶段时变成2星。把这个效果适用的怪兽作为同调素材
-- 的场合，不是不死族怪兽的同调召唤不能使用。
--[[ __CARD_HEADER_END__ ]]

--ペインペインター
function c21620076.initial_effect(c)
	--alias
	aux.EnableChangeCode(c,33420078)
	--lvchange
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21620076,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c21620076.lvtg)
	e2:SetOperation(c21620076.lvop)
	c:RegisterEffect(e2)
end
function c21620076.lvfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE) and not c:IsLevel(2) and c:IsLevelAbove(1)
end
function c21620076.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c21620076.lvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c21620076.lvfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c21620076.lvfilter,tp,LOCATION_MZONE,0,1,2,e:GetHandler())
end
function c21620076.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	while tc do
		if tc:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(2)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
			e2:SetValue(c21620076.synlimit)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
		end
		tc=g:GetNext()
	end
end
function c21620076.synlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_ZOMBIE)
end
