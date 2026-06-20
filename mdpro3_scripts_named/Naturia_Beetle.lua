--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 自然甲虫  (ID: 27762803)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 4
-- ATK 400 | DEF 1800
-- Setcode: 42
--
-- Effect Text:
-- 每次魔法卡发动，这张卡的原本攻击力·守备力交换。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・ビートル
function c27762803.initial_effect(c)
	--ad change
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetOperation(c27762803.adop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_SWAP_BASE_AD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c27762803.con)
	c:RegisterEffect(e2)
end
function c27762803.con(e)
	return e:GetHandler():GetFlagEffect(27762803)~=0
end
function c27762803.adop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) then
		if e:GetHandler():GetFlagEffect(27762803)==0 then
			e:GetHandler():RegisterFlagEffect(27762803,RESET_EVENT+RESETS_STANDARD+RESET_DISABLE,0,0)
		else
			e:GetHandler():ResetFlagEffect(27762803)
		end
	end
end
