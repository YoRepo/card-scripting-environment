--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 仪式魔人 布置者  (ID: 30492798)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 200 | DEF 200
-- Setcode: 109
--
-- Effect Text:
-- 仪式怪兽的仪式召唤进行的场合，可以作为那次仪式召唤需要的等级数值的1只怪兽，把墓地存在的这张卡从游戏中除外。把这张卡在仪式召唤使用的仪式怪兽不受陷阱卡的效果影响。
--[[ __CARD_HEADER_END__ ]]

--儀式魔人ディザーズ
function c30492798.initial_effect(c)
	--ritual material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_RITUAL_MATERIAL)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--become material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_EVENT_PLAYER)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c30492798.condition)
	e2:SetOperation(c30492798.operation)
	c:RegisterEffect(e2)
end
function c30492798.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL and not e:GetHandler():IsPreviousLocation(LOCATION_OVERLAY)
end
function c30492798.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(30492798)==0 then
			--immune
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetDescription(aux.Stringid(30492798,0))
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_IMMUNE_EFFECT)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(c30492798.efilter)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(30492798,RESET_EVENT+RESETS_STANDARD,0,1)
		end
		rc=eg:GetNext()
	end
end
function c30492798.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP)
end
