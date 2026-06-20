--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 炒土地  (ID: 61264008)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己或者对方的场地区域1张表侧表示的卡为对象才能发动。那张卡除外。那之后，这个效果除外的卡在从被除外的玩家来看的对方的场地区域表侧表示放置。那之后，可以从被放置的玩家的墓地选原本卡名和放置的卡不
-- 同的1张场地魔法卡在被这个效果把卡除外的玩家的场地区域表侧表示放置。
--[[ __CARD_HEADER_END__ ]]

--土地ころがし
function c61264008.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,61264008+EFFECT_COUNT_CODE_OATH)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c61264008.target)
	e1:SetOperation(c61264008.activate)
	c:RegisterEffect(e1)
end
function c61264008.filter(c)
	return c:IsFaceup() and c:IsAbleToRemove()
end
function c61264008.filter2(c,code)
	return c:IsType(TYPE_FIELD) and not c:IsCode(code)
end
function c61264008.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_FZONE) and c61264008.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c61264008.filter,tp,LOCATION_FZONE,LOCATION_FZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c61264008.filter,tp,LOCATION_FZONE,LOCATION_FZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c61264008.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local ttp=tc:GetControler()
		if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0 then
			local g=Duel.GetOperatedGroup()
			local tc2=g:GetFirst()
			local code=tc2:GetOriginalCode()
			if Duel.MoveToField(tc2,1-ttp,1-ttp,LOCATION_FZONE,POS_FACEUP,true)~=0
				and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c61264008.filter2),1-ttp,LOCATION_GRAVE,0,1,nil,code)
				and Duel.SelectYesNo(tp,aux.Stringid(61264008,0)) then
				Duel.BreakEffect()
				local rg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c61264008.filter2),1-ttp,LOCATION_GRAVE,0,1,1,nil,code)
				if #rg>0 then
					Duel.MoveToField(rg:GetFirst(),tp,ttp,LOCATION_FZONE,POS_FACEUP,true)
				end
			end
		end
	end
end
